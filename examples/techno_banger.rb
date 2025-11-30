# Techno Banger with Synth-Pop Lead
use_bpm 132

live_loop :kick do
  sample :bd_haus, amp: 1.6, cutoff: 120
  sleep 1
end

live_loop :hats do
  4.times do |i|
    accent = (i % 2 == 0) ? 0.55 : 0.4
    sample :drum_cymbal_closed, amp: accent, finish: 0.2, cutoff: 125
    sleep 0.25
  end
  sample :drum_cymbal_open, amp: 0.25, finish: 0.2, release: 0.1 if one_in(6)
end

live_loop :clap do
  sleep 1
  sample :elec_hi_snare, amp: 0.9, cutoff: 120
  sleep 1
end

live_loop :bass do
  use_synth :fm
  notes = (ring :e1, :e1, :g1, :e1, :d1, :e1, :g1, :e1)
  with_fx :distortion, distort: 0.45 do
    8.times do
      n = notes.tick
      play n, release: 0.3, depth: 2, divisor: 0.5, cutoff: 90
      sleep 0.5
      play n + 12, release: 0.15, depth: 1.4, divisor: 0.25, amp: 0.7 if one_in(3)
      sleep 0.5
    end
  end
end

live_loop :stabs do
  sync :kick
  use_synth :prophet
  with_fx :echo, phase: 0.375, decay: 4 do
    chords = (ring chord(:e3, :minor7), chord(:g3, :sus2), chord(:d3, :minor7), chord(:c3, :maj9))
    play chords.tick, release: 0.5, cutoff: 75, amp: 0.6
  end
  sleep 2
end

live_loop :lead do
  sync :kick
  use_synth :blade
  with_fx :reverb, room: 0.6, mix: 0.35 do
    melody = (ring :b4, :g4, :e4, :g4, :b4, :d5, :c5, :g4,
                  :b4, :g4, :e4, :g4, :b4, :d5, :e5, :d5)
    16.times do
      n = melody.tick
      play n, release: 0.25, attack: 0.02, cutoff: 95, amp: 0.9, vibrato_rate: 6, vibrato_depth: 0.1
      sleep 0.25
    end
  end
end
