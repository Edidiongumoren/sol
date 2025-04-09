#!/bin/bash
set -e

echo "=== Setting up persistent Solana/Anchor environment ==="

# Install Solana (if not exists)
if ! command -v solana &> /dev/null; then
    sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
    export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
fi

# Install Anchor (if not exists)
if ! command -v anchor &> /dev/null; then
    cargo install --git https://github.com/coral-xyz/anchor anchor-cli --locked
fi

# Initialize project if empty
if [ ! -f "Anchor.toml" ]; then
    echo "Initializing new Anchor project..."
    mkdir -p programs/myprogram/src
    cat > programs/myprogram/src/lib.rs << 'LIBEOF'
use anchor_lang::prelude::*;

declare_id!("Fg6PaFpoGXkYsidMpWTK6W2BeZ7FEfcYkg476zPFsLnS");

#[program]
pub mod myprogram {
    use super::*;
    pub fn initialize(_ctx: Context<Initialize>) -> Result<()> {
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
LIBEOF

    cat > Anchor.toml << 'ANCHOREOF'
[provider]
cluster = "localnet"
wallet = "~/.config/solana/id.json"

[programs.localnet]
myprogram = "Fg6PaFpoGXkYsidMpWTK6W2BeZ7FEfcYkg476zPFsLnS"
ANCHOREOF
fi

# Persist paths
echo "export PATH=\"\$HOME/.local/share/solana/install/active_release/bin:\$PATH\"" >> ~/.bashrc
echo "=== Setup complete ==="
