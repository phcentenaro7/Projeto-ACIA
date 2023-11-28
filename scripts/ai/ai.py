import os
import cv2
from time import time
import numpy as np
import tensorflow as tf
from efficientnet.tfkeras import EfficientNetB0

path = f"{os.path.dirname(os.path.abspath(__file__))}"

# Hide GPU from visible devices
tf.config.set_visible_devices([], 'GPU')

config = tf.compat.v1.ConfigProto()
config.gpu_options.allow_growth = True
session = tf.compat.v1.Session(config=config)
os.environ['CUDA_VISIBLE_DEVICES'] = '-11'

# Carregar o modelo YOLO
path = f"{os.path.dirname(os.path.abspath(__file__))}"
model_path = os.path.join(path, 'modelogoogle.h5')
model = tf.keras.models.load_model(model_path)  # Carregar o modelo treinado

# Criar a captura de vídeo para a câmera ao vivo
captures = [cv2.VideoCapture(2), cv2.VideoCapture(4)]

# Verificar se a captura de vídeo foi inicializada corretamente
if not all([capture.isOpened() for capture in captures]):
    print("Erro ao acessar a câmera.")
    exit()

open(os.path.join(path, "python_script_loaded"), "w").close()
is_program_running = True

then = 0
now = 0

while is_program_running:
    now = time()
    is_camera_enabled = []
    video_frames = []
    camera_predictions = []
    predictions = []
    for capture in captures:
        video_reading = capture.read()
        is_camera_enabled.append(video_reading[0])
        video_frames.append(video_reading[1])
    if not all([enabled for enabled in is_camera_enabled]):
        break
    if os.path.exists(os.path.join(path, "request_python_close")):
        os.remove(os.path.join(path, "request_python_close"))
        break
    if now - then >= 0.5:
        then = now
        classes = ['batata', 'berinjela', 'cenoura', 'chuchu', 'maçã', 'rabanete', 'tomate']
        for video_frame in video_frames:
            video_frame = cv2.cvtColor(video_frame, cv2.COLOR_BGR2RGB)
            video_frame = cv2.resize(video_frame, (224, 224))
            video_frame = video_frame/255.0
            camera_predictions.append(model.predict(np.expand_dims(video_frame, axis=0))[0][:])
            for i in range(len(classes)):
                class_name = classes[i]
                probability = camera_predictions[len(camera_predictions) - 1][i] * 100  # Probabilidade da classe i em porcentagem
                print(f"Probabilidade de {class_name}: {probability:.2f}%")
        predictions = sum(camera_predictions)
        predictions, classes = zip(*sorted(zip(predictions, classes), reverse=True))
        with open(os.path.join(path, 'top_results'), 'w') as f:
            f.write(f"{classes[0]}\n")
            f.write(f"{classes[1]}\n")
            f.write(f"{classes[2]}\n")

for capture in captures:
	capture.release()
cv2.destroyAllWindows()
