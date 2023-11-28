using Godot;
using System;
using System.Data.Common;
using System.Text;
using System.Drawing;
using System.IO;
using MySqlConnector;
using System.Linq;

namespace System{
	public partial class database : Node
	{
		public bool all_loaded = false;
		static MySqlConnection connection = new MySqlConnection();
		bool processing = false;
		// Called when the node enters the scene tree for the first time.
		public override async void _Ready()
		{
			File.Delete("images/info.txt");
			connection.ConnectionString = "Server=localhost;User ID=root;Password=ufsc2023;Database=caixasmart";
			try{
				await connection.OpenAsync();
			}
			catch(Exception e){
				GD.Print(e.Message);
			}
			string[] specific = {};
			using var generic_cmd = new MySqlCommand("SELECT * FROM generic_product", connection);
			await using var generic_reader = await generic_cmd.ExecuteReaderAsync();
			while(await generic_reader.ReadAsync()){
				string name = (string)generic_reader.GetValue(0);
				byte[] image_bytes = (byte[])generic_reader.GetValue(1);
				File.WriteAllBytes($"images/{name}.jpg", image_bytes);
                float price = decimal.ToSingle((decimal)generic_reader.GetValue(2));
				if(price == 0){
					File.AppendAllText("images/info.txt", $"generic {name}" + Environment.NewLine);
				}
				else{
					File.AppendAllText("images/info.txt", $"specific-notype {name},{price:00.00}" + Environment.NewLine);
				}
			}
			generic_reader.Close();
			using var specific_cmd = new MySqlCommand("SELECT * FROM specific_product", connection);
			await using var specific_reader = await specific_cmd.ExecuteReaderAsync();
			while(await specific_reader.ReadAsync()){
				string name = (string)specific_reader.GetValue(0);
				string type = (string)specific_reader.GetValue(1);
				GD.Print(name + " " + type);
				float price = decimal.ToSingle((decimal)specific_reader.GetValue(2));
				File.AppendAllText("images/info.txt", $"specific {name}-{type},{price:00.00}" + Environment.NewLine);
				byte[] image_bytes = (byte[])specific_reader.GetValue(3);
				File.WriteAllBytes($"images/{name}-{type}.jpg", image_bytes);
			}
			specific_reader.Close();
			all_loaded = true;
			return;
		}

		// Called every frame. 'delta' is the elapsed time since the previous frame.
		public override void _Process(double delta)
		{

		}
	}
}