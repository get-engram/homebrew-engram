# Homebrew Tap for Engram

Persistent memory for AI agents. Auto-captures Claude Code conversations and makes them searchable.

## Install

```bash
brew tap get-engram/engram
brew install engram
```

## Start the daemon

The daemon watches `~/.claude/projects/` for Claude Code transcripts and syncs them to your Engram account.

```bash
# Authenticate first
engram auth login <your-api-key>

# Start as a background service (auto-starts on login)
brew services start engram

# Check status
engram status

# Stop
brew services stop engram
```

## CLI usage

```bash
engram search "when did we deploy"    # Semantic search across memory
engram log                            # Recent AI conversation activity
engram store -c <id> "some note"      # Store a message manually
engram conversations list             # List all conversations
```

## Links

- [Website](https://getengram.app)
- [GitHub](https://github.com/get-engram/engram)
- [npm](https://www.npmjs.com/package/@getengram/cli)
