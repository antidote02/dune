from tkinterdnd2 import TkinterDnD, DND_FILES
import tkinter as tk
import subprocess
import os
class FFprobeL:
    def __init__(self):
        self.root = TkinterDnD.Tk()
        self.root.title("FFprobeL")
        self.root.geometry("640x360")
        self.root.configure(bg='white')
        self.root.eval('tk::PlaceWindow . center')
        self.mf = tk.Frame(self.root, bg='white')
        self.mf.place(relx=0.5, rely=0.5, anchor='center')
        f = ('SimSun', 12)
        l = [("Duration:", 0), ("Video:", 1), ("AVG Frame Rate:", 2), ("R Frame Rate:", 3), ("-vf:", 4)]
        self.vl = []
        for t, r in l:
            tk.Label(self.mf, text=t, bg='white', font=f).pack(pady=2)
            vl = tk.Label(self.mf, text="N/A", bg='white', font=f, fg='gray')
            vl.pack(pady=2)
            self.vl.append(vl)
        self.root.drop_target_register(DND_FILES)
        self.root.dnd_bind('<<Drop>>', self.on_file_drop)
        self.root.bind('<Escape>', lambda e: self.root.quit())
        self.root.bind('<Double-Button-1>', self.copy_avg_frame_rate)
        self.cars = ""
    def on_file_drop(self, e):
        fp = e.data.strip('{}')
        if fp and os.path.isfile(fp): 
            self.analyze_video(fp)
    def copy_avg_frame_rate(self, e):
        if not self.cars: 
            return
        if '/' in self.cars:
            n, d = map(int, self.cars.split('/'))
            c = str(n) if d == 1 else self.cars
        else: 
            c = self.cars
        self.root.clipboard_clear()
        self.root.clipboard_append(c)
    def analyze_video(self, fp):
        try:
            cmd = ['ffprobe', '-v', 'quiet', '-print_format', 'json', '-show_format', '-show_streams', fp]
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode != 0:
                return
            import json
            data = json.loads(result.stdout)
            video_stream = None
            for stream in data.get('streams', []):
                if stream.get('codec_type') == 'video':
                    video_stream = stream
                    break
            if not video_stream:
                return
            duration = float(data.get('format', {}).get('duration', 0))
            h, m, s = int(duration // 3600), int((duration % 3600) // 60), duration % 60
            ds_str = f"{h:02d}:{m:02d}:{s:05.2f}"
            self.vl[0].config(text=ds_str, fg='red' if duration > 15 else 'black')
            codec = video_stream.get('codec_name', 'unknown').upper()
            width = video_stream.get('width', 0)
            height = video_stream.get('height', 0)
            sar = video_stream.get('sample_aspect_ratio', '1:1')
            vi = f"{codec}, {width}x{height}, SAR {sar}"
            rc = 'red' if (width > 1080 or height > 1920 or sar != "1:1") else 'black'
            self.vl[1].config(text=vi, fg=rc)
            ar = video_stream.get('avg_frame_rate', '0/1')
            rr = video_stream.get('r_frame_rate', '0/1')
            self.cars = ar
            def fr(rs):
                if '/' in rs:
                    n, d = map(int, rs.split('/'))
                    dec = n / d if d != 0 else 0
                    return str(n) if d == 1 else f"{rs} ({dec:.2f})"
                else:
                    dec = float(rs)
                    return str(int(dec)) if dec.is_integer() else f"{rs} ({dec:.2f})"
            far, frr = fr(ar), fr(rr)
            if rr == ar:
                far_tagged = far + " CFR"
            else:
                far_tagged = far + " VFR"
            tc = 'black' if rr == ar else 'red'
            self.vl[2].config(text=far_tagged, fg=tc)
            self.vl[3].config(text=frr, fg=tc)
            if ':' in sar:
                sx, sy = map(int, sar.split(':'))
                sr = sx / sy
            else:
                sr = 1.0
            dar = (width / height) * sr
            sf = "scale=1080:-2" if dar >= 9/16 else "scale=-2:1920"
            hr = (duration > 15) or (width > 1080 or height > 1920 or sar != "1:1") or (rr != ar)
            vc = 'blue' if hr else 'black'
            self.vl[4].config(text=sf, fg=vc)
        except Exception as e:
            print(f"Error: {e}")
    def run(self): 
        self.root.mainloop()
if __name__ == "__main__":
    FFprobeL().run()
