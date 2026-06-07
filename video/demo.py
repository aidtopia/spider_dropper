# OpenSCAD on Windows cannot animate more than one frame when launched from
# the command line.  Thus this hack to drive the animation frame-by-frame.

import math
import subprocess

def generate_frame(n, angle=0):
    command = f"openscad -o frame{n:05d}.png -D \"Motor_Angle={angle}\" -D \"Motor_Type=\"\"Reindeer\"\"\" -D \"Preview_Motor=true\" --camera 20,-150,400,20,0,0 --imgsize=1920,1080 --colorscheme=\"Tomorrow Night\" ..\parts\spider_dropper2.scad"
    print(f"$ {command}\n")
    result = subprocess.run(command, capture_output=True)
    if result.returncode != 0:
        print(f"!!!\nFailed to generate frame {n}\n")
        print(f"exit status {result.returncode}\n---\n")
        return False
    return True

def combine_frames(frame_rate=30):
    command = f"ffmpeg -framerate {frame_rate} -i \"frame%05d.png\" -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p video.mp4"
    print(f"$ {command}\n")
    result = subprocess.run(command, capture_output=True)
    if result.returncode != 0:
        print(f"!!!\nFailed to generate video file\n")
        print(f"exit status: {result.returncode}\n---\n")
        print(result.stderr)
        return False
    return True

def __main__():
    frame_rate = 60
    duration   = 10
    total_frames = math.ceil(frame_rate * duration)
    revolutions_per_minute = 6
    revolutions = duration * revolutions_per_minute / 60;
    total_angle = 360.0 * revolutions;

    for n in range(total_frames):
        angle = n * total_angle / total_frames
        if not generate_frame(n, angle):
            exit();

    combine_frames(frame_rate);

if __name__ == '__main__':
  __main__()
