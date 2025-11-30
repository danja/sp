# Industrial Techno Pulse
use_bpm 140

live_loop :kick do
  with_fx :distortion, distort: 0.2 do
    sample :bd_haus, amp: 1.8, cutoff: 110
  end
  sleep 1
end

live_loop :hats do
  4.times do |i|
    accent = (i == 0 || i == 2) ? 0.65 : 0.45
    sample :drum_cymbal_closed, finish: 0.18, amp: accent, cutoff: 130
    sleep 0.25
  end
  sample :drum_cymbal_open, amp: 0.35, finish: 0.25, release: 0.12 if one_in(4)
end

live_loop :snare do
  sleep 1
  with_fx :distortion, distort: 0.35 do
    sample :elec_snare, amp: 1.0, cutoff: 120
  end
  sleep 1
end

live_loop :industrial_bass do
  use_synth :fm
  notes = (ring :e1, :e1, :g1, :e1, :bb0, :e1, :g1, :e1)
  with_fx :distortion, distort: 0.5, amp: 1.0 do
    8.times do
      n = notes.tick
      play n, release: 0.25, depth: 2, divisor: 0.5, cutoff: 90
      sleep 0.5
      play n + 12, release: 0.12, depth: 1.5, divisor: 0.25, amp: 0.7 if one_in(3)
      sleep 0.25
      sample :elec_blip2, amp: 0.3, finish: 0.1, cutoff: 110
      sleep 0.25
    end
  end
end

live_loop :stabs do
  sync :kick
  use_synth :prophet
  with_fx :echo, phase: 0.5, decay: 4 do
    chords = (ring chord(:e3, :minor), chord(:f3, :minor), chord(:g3, :minor))
    play chords.tick, release: 0.4, cutoff: 80, amp: 0.7
  end
  sleep 2
end

live_loop :noise_sweep do
  sync :kick
  with_fx :hpf, cutoff: 90 do
    with_fx :reverb, room: 0.8, mix: 0.4 do
      sample :ambi_lunar_land, amp: 0.5, rate: 0.5, start: 0.2, finish: 0.7
    end
  end
  sleep 8
end
