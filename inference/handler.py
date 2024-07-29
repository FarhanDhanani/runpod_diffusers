import runpod
import torch
import comet_ml
from diffusers import DiffusionPipeline

LORA_WEIGHTS_PATH = "../training/lora_weight.pkt"
PRETAINED_MODEL_PATH = "../training/stable-diffusion-v1.5.pkt"
def image_generator_handler(job):

    torch.cuda.empty_cache()
    torch.cuda.memory_summary(device=None, abbreviated=False)
    prompts = job["prompts"]

    validation_prompts = ""

    pipeline = DiffusionPipeline.from_pretrained("runwayml/stable-diffusion-v1-5")
    pipeline.load_lora_weights(LORA_WEIGHTS_PATH)
    experiment = comet_ml.Experiment(api_key="mPoTRh1y7mZY5fZkureL9BdA8")

    for product_prompt in prompts:
        prompt = product_prompt["prompt"]
        validation_prompts = str(prompt).replace("[V]", "")
        with torch.no_grad():
            images = pipeline(
                prompt = prompt,
                num_inference_steps=2
            ).images
            experiment.log_image(images[0], metadata={
                "prompt": prompt,
                "model": PRETAINED_MODEL_PATH,
            })

    return images[0]

runpod.serverless.start(
    {
        "handler": image_generator_handler
    }
)