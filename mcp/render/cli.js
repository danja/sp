#!/usr/bin/env node
// CLI entrypoint to render Sonic Pi Ruby files to MIDI outside MCP
import path from 'path';
import { renderSonicPiToMidi } from './index.js';

function printHelp() {
  console.log(`Usage: sp-mc-render --path <file.rb> [options]

Options:
  --path <file>           Sonic Pi .rb file to render (required)
  --output <file.mid>     Output MIDI path (default: alongside source)
  --bars <n>              Number of bars to unroll (default: 8)
  --loops <a,b,c>         Comma-separated live_loop names to include
  --no-drum-split         Keep all drums on one track
  --help                  Show this help

Example:
  sp-mc-render --path examples/techno_banger.rb --output out.mid --bars 8 --loops kick,hats,bass,lead`);
}

function parseArgs(argv) {
  const out = { drumSplit: true };
  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (!arg.startsWith('--')) {
      continue;
    }
    if (arg === '--help' || arg === '-h') {
      out.help = true;
      continue;
    }
    if (arg === '--no-drum-split') {
      out.drumSplit = false;
      continue;
    }
    const [flag, inlineVal] = arg.split('=');
    const nextVal = argv[i + 1] && !argv[i + 1].startsWith('--') ? argv[i + 1] : undefined;
    const value = inlineVal !== undefined ? inlineVal : nextVal;
    if (nextVal && inlineVal === undefined) i += 1;
    switch (flag) {
      case '--path':
        out.path = value;
        break;
      case '--output':
        out.output = value;
        break;
      case '--bars':
        out.bars = Number(value);
        break;
      case '--loops':
        out.loops = value ? value.split(',').map((s) => s.trim()).filter(Boolean) : [];
        break;
      default:
        console.warn(`Unknown option: ${flag}`);
    }
  }
  return out;
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  if (args.help || !args.path) {
    printHelp();
    if (!args.path) process.exitCode = 1;
    return;
  }

  try {
    const result = renderSonicPiToMidi({
      filePath: args.path,
      bars: args.bars,
      output: args.output,
      loopNames: args.loops,
      drumSplit: args.drumSplit,
    });

    const summary = `MIDI written to ${path.resolve(result.midiPath)}
Tracks: ${result.tracks
  .map(
    (t) =>
      `${t.name} (channel ${t.channel + 1}${t.isPercussion ? ', drums' : ''}, program ${t.instrumentNumber})`
  )
  .join('; ')}
Events: ${result.eventCount}
Warnings: ${result.warnings.length ? result.warnings.join(' | ') : 'none'}`;

    console.log(summary);
  } catch (err) {
    console.error(`Error: ${err.message}`);
    process.exitCode = 1;
  }
}

main();
