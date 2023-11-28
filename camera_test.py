import cv2
from pynput import keyboard
import os

camera_id = 0
zoom_factor = 1.0

def on_press(key):
    try:
        if keyboard.Key.up:
            zoom_factor += 0.05
        elif keyboard.Key.down:
            zoom_factor -= 0.05
        elif keyboard.Key.left or keyboard.Key.right:
            camera_id ^= 1
        os.system("clear")
        print("Camera {0} zoom factor = {1}".format(camera_id, zoom_factor))
        print("Camera ID switched to {0}".format(camera_id))
    except AttributeError:
        print("Failed to respond to key {0}".format(key))

captures = []
captures.append(cv2.VideoCapture(3))
captures.append(cv2.VideoCapture(5))

print(captures[0].isOpened())
print(captures[1].isOpened())

if not all([capture.isOpened() for capture in captures]):
    exit()

program_running = True

while program_running:
    for capture in captures:
        print(capture)
        if not capture.isOpened():
            capture.release()
            program_running = False
        is_camera_enabled, video_frame = capture.read()
        if not is_camera_enabled:
            capture.release()
            program_running = False
            break
        cv2.imshow("{0}".format(capture), video_frame)
        cv2.waitKey(100)

capture.destroyAllWindows()
