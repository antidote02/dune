from tkinterdnd2 import TkinterDnD, DND_FILES
import tkinter as tk
import os
import random
from datetime import datetime
import ctypes
from ctypes import wintypes
class Rand:
    def __init__(self):
        self.root = TkinterDnD.Tk()
        self.root.title("Rand")
        self.root.geometry("640x360")
        self.root.configure(bg='white')
        self.root.eval('tk::PlaceWindow . center')
        self.main_frame = tk.Frame(self.root, bg='white')
        self.main_frame.place(relx=0.5, rely=0.5, anchor='center')
        font_style = ('SimSun', 12)
        labels = [("New:", 0), ("Old:", 1), ("Rand:", 2)]
        self.value_labels = []
        for text, row in labels:
            tk.Label(self.main_frame, text=text, bg='white', font=font_style).pack(pady=2)
            value_label = tk.Label(self.main_frame, text="N/A", bg='white', font=font_style, fg='gray')
            value_label.pack(pady=2)
            self.value_labels.append(value_label)
        self.root.drop_target_register(DND_FILES)
        self.root.dnd_bind('<<Drop>>', self.on_file_drop)
        self.root.bind('<Escape>', lambda e: self.root.quit())
        self.current_stage = 0
        self.time1 = None
        self.time2 = None
    def on_file_drop(self, event):
        file_path = event.data.strip('{}')
        if file_path and os.path.isfile(file_path): self.process_file(file_path)
    def get_file_time(self, file_path):
        if not os.path.exists(file_path): return None
        mtime = os.path.getmtime(file_path)
        return datetime.fromtimestamp(mtime).strftime('%Y-%m-%d %H:%M:%S')
    def set_file_time_windows(self, file_path, time_str):
        try:
            time_obj = datetime.strptime(time_str, '%Y-%m-%d %H:%M:%S')
            timestamp = time_obj.timestamp()
            os.utime(file_path, (timestamp, timestamp))
            if os.name == 'nt':
                kernel32 = ctypes.windll.kernel32
                CreateFileW = kernel32.CreateFileW
                SetFileTime = kernel32.SetFileTime
                CloseHandle = kernel32.CloseHandle
                handle = CreateFileW(file_path, 0x100, 0, None, 3, 0x80, None)
                if handle != -1:
                    time_val = int((timestamp + 11644473600) * 10000000)
                    file_time = wintypes.FILETIME()
                    file_time.dwLowDateTime = time_val & 0xFFFFFFFF
                    file_time.dwHighDateTime = time_val >> 32
                    SetFileTime(handle, ctypes.byref(file_time), None, None)
                    CloseHandle(handle)
            return True
        except Exception as e: return False
    def process_file(self, file_path):
        if self.current_stage == 0:
            time_str = self.get_file_time(file_path)
            self.time1 = time_str
            self.value_labels[0].config(text=time_str, fg='black')
            self.value_labels[1].config(text="N/A", fg='gray')
            self.value_labels[2].config(text="N/A", fg='gray')
            self.current_stage = 1
            return
        if self.current_stage == 1:
            time_str = self.get_file_time(file_path)
            time1_obj = datetime.strptime(self.time1, '%Y-%m-%d %H:%M:%S')
            time2_obj = datetime.strptime(time_str, '%Y-%m-%d %H:%M:%S')
            if time2_obj < time1_obj:
                self.time2 = time_str
                self.value_labels[1].config(text=time_str, fg='black')
                self.value_labels[2].config(text="N/A", fg='gray')
                self.current_stage = 2
            else:
                self.value_labels[1].config(text="Error", fg='red')
                self.value_labels[2].config(text="N/A", fg='gray')
                self.current_stage = 0
                self.time1 = None
            return
        if self.current_stage == 2:
            if self.time1 is None or self.time2 is None:
                self.value_labels[2].config(text="Error", fg='red')
                return
            time1_obj = datetime.strptime(self.time1, '%Y-%m-%d %H:%M:%S')
            time2_obj = datetime.strptime(self.time2, '%Y-%m-%d %H:%M:%S')
            if time1_obj > time2_obj: time1_obj, time2_obj = time2_obj, time1_obj
            time_diff = (time2_obj - time1_obj).total_seconds()
            if time_diff <= 0:
                self.value_labels[2].config(text="Error", fg='red')
                return
            random_seconds = random.uniform(0, time_diff)
            random_time = time1_obj.timestamp() + random_seconds
            random_time_obj = datetime.fromtimestamp(random_time)
            random_time_str = random_time_obj.strftime('%Y-%m-%d %H:%M:%S')
            if self.set_file_time_windows(file_path, random_time_str):
                self.value_labels[2].config(text=random_time_str, fg='black')
                self.current_stage = 0
                self.time1 = None
                self.time2 = None
            else: self.value_labels[2].config(text="Error", fg='red')
    def run(self): self.root.mainloop()
if __name__ == "__main__":
    Rand().run()