using Godot;
using System.IO.Ports;
using System.Runtime.CompilerServices;
using System.Globalization;

public partial class serial : Node
{
	public string weight;
	public float weight_as_number;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
        SerialPort port = new SerialPort("/dev/ttyUSB0")
        {
            Parity = Parity.None,
            StopBits = StopBits.One,
            DataBits = 8,
            Handshake = Handshake.None
        };
        port.DataReceived += new SerialDataReceivedEventHandler(DataReceivedHandler);
		port.Open();
	}

	private void DataReceivedHandler(object sender, SerialDataReceivedEventArgs e)
	{
    	SerialPort sp = (SerialPort)sender;
    	weight = sp.ReadExisting();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
