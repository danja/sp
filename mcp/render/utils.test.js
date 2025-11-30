import { describe, it, expect } from 'vitest';
import { chordToMidis, noteSymbolToMidi } from './utils.js';
import { mapSampleToDrum } from './constants.js';

describe('music utils', () => {
  it('maps chord qualities to midi arrays', () => {
    expect(chordToMidis('c3', 'major')).toEqual([48, 52, 55]);
    expect(chordToMidis('c3', 'm7')).toEqual([48, 51, 55, 58]);
    expect(chordToMidis('c3', 'add9')).toEqual([48, 52, 55, 62]);
  });

  it('parses note symbols with sharps/flats', () => {
    expect(noteSymbolToMidi(':C4')).toBe(60);
    expect(noteSymbolToMidi(':cs4')).toBe(61);
    expect(noteSymbolToMidi(':Db4')).toBe(61);
  });

  it('maps common samples to drum metadata', () => {
    expect(mapSampleToDrum(':drum_bass_hard')).toMatchObject({ midi: 36, id: 'kick' });
    expect(mapSampleToDrum(':elec_tick')).toMatchObject({ midi: 37, id: 'tick' });
    expect(mapSampleToDrum(':elec_fuzz_tom')).toMatchObject({ id: 'tom_mid' });
  });
});
