import tkinter as tk
from tkinter import ttk
import serial
from serial.tools import list_ports
from threading import Thread

class SerialMonitorApp:
    def __init__(self, root):
        self.root = root
        self.root.title("ESP8266 Serial Monitor")
        
                # Button zum Scannen von Ports
        scan_button = tk.Button(root, text="Ports scannen", command=self.scan_ports)
        scan_button.grid(row=0, column=4, padx=10, pady=5)


        # Dropdown-Menü für Port und Baudrate
        self.port_var = tk.StringVar()
        self.baudrate_var = tk.StringVar()

        port_label = tk.Label(root, text="Port:")
        port_label.grid(row=0, column=0, padx=10, pady=5, sticky=tk.W)
        self.port_dropdown = ttk.Combobox(root, textvariable=self.port_var)
        self.port_dropdown.grid(row=0, column=1, padx=10, pady=5)
        self.port_dropdown['values'] = self.get_serial_ports()
        self.port_dropdown.set(self.port_dropdown['values'][0])

        baudrate_label = tk.Label(root, text="Baudrate:")
        baudrate_label.grid(row=0, column=2, padx=10, pady=5, sticky=tk.W)
        self.baudrate_dropdown = ttk.Combobox(root, textvariable=self.baudrate_var)
        self.baudrate_dropdown.grid(row=0, column=3, padx=10, pady=5)
        self.baudrate_dropdown['values'] = ['9600', '115200']
        self.baudrate_dropdown.set('115200')

        # Textfeld für den Serial Monitor
        self.output_text = tk.Text(root, height=15, width=50, wrap=tk.WORD)
        self.output_text.grid(row=1, column=0, columnspan=4, padx=10, pady=5)

        # Textfeld für den zu sendenden Text
        self.input_text = tk.Entry(root, width=30)
        self.input_text.grid(row=2, column=0, padx=10, pady=5)

        # Senden-Button
        send_button = tk.Button(root, text="Senden", command=self.send_text)
        send_button.grid(row=2, column=1, padx=10, pady=5)

        # Verbindungsstatus
        self.connection_status = tk.StringVar()
        self.connection_status.set("Nicht verbunden")
        status_label = tk.Label(root, textvariable=self.connection_status)
        status_label.grid(row=3, column=0, columnspan=4, pady=10)

        # Verbinden/Verbindungsabbrechen-Button
        self.connect_button = tk.Button(root, text="Verbinden", command=self.toggle_connection)
        self.connect_button.grid(row=4, column=0, columnspan=4, pady=10)

        # Serielle Verbindung
        self.ser = None
        self.connected = False

    def scan_ports(self):
        # Scanne verfügbare Ports und aktualisiere Dropdown-Menü
        ports = [port.device for port in list_ports.comports()]
        self.port_dropdown['values'] = ports
        if ports:
            self.port_dropdown.set(ports[0])
        else:
            self.port_dropdown.set("")
            
    def get_serial_ports(self):
        # Funktion, um verfügbare serielle Ports zu erhalten
        # Hier kann die Logik angepasst werden, um die Ports auf Ihrem System zu erkennen
        return ['COM1', 'COM2', 'COM3', 'COM4']

    def toggle_connection(self):
        if not self.connected:
            port = self.port_var.get()
            baudrate = int(self.baudrate_var.get())

            try:
                self.ser = serial.Serial(port, baudrate, timeout=0)
                self.connected = True
                self.connection_status.set(f"Verbunden mit {port} ({baudrate} bps)")
                self.connect_button.config(text="Verbindung trennen")
                # Starte einen Thread, um den Serial Monitor auszulesen
                Thread(target=self.read_serial).start()
            except serial.SerialException as e:
                self.connection_status.set(f"Fehler beim Verbinden: {str(e)}")
        else:
            self.ser.close()
            self.connected = False
            self.connection_status.set("Nicht verbunden")
            self.connect_button.config(text="Verbinden")

    def read_serial(self):
        while self.connected:
            try:
                data = self.ser.readline().decode('utf-8')
                self.output_text.insert(tk.END, data)
                self.output_text.see(tk.END)
            except serial.SerialException:
                # Verbindung wurde getrennt
                self.connected = False
                self.connection_status.set("Nicht verbunden")
                self.connect_button.config(text="Verbinden")

    def send_text(self):
        if self.connected:
            text = self.input_text.get()
            self.ser.write(text.encode('utf-8'))
            self.input_text.delete(0, tk.END)

if __name__ == "__main__":

      # Erstelle drei Instanzen der Anwendung
    root1 = tk.Tk()
    app1 = SerialMonitorApp(root1)

#    root2 = tk.Tk()
#    app2 = SerialMonitorApp(root2)

#    root3 = tk.Tk()
#    app3 = SerialMonitorApp(root3)

    # Starte die GUIs
    root1.mainloop()
   # root2.mainloop()
   # root3.mainloop()
