
 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"


      waveform add -signals /rom_initial_tb/status
      waveform add -signals /rom_initial_tb/rom_initial_synth_inst/bmg_port/RSTA
      waveform add -signals /rom_initial_tb/rom_initial_synth_inst/bmg_port/CLKA
      waveform add -signals /rom_initial_tb/rom_initial_synth_inst/bmg_port/ADDRA
      waveform add -signals /rom_initial_tb/rom_initial_synth_inst/bmg_port/ENA
      waveform add -signals /rom_initial_tb/rom_initial_synth_inst/bmg_port/REGCEA
      waveform add -signals /rom_initial_tb/rom_initial_synth_inst/bmg_port/DOUTA
console submit -using simulator -wait no "run"
