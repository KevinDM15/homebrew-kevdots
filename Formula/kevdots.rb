class Kevdots < Formula
  desc "Personal dotfiles installer — Alacritty + Zellij + LazyVim + Starship + Zsh"
  homepage "https://github.com/KevinDM15/KevDots"
  url "https://github.com/KevinDM15/KevDots/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "35644e894decd9bd30f89e8ac301d4d48bbf6def20ad419bad0662af79eaf3ba"
  license "MIT"

  depends_on "git"
  depends_on "zsh"
  depends_on :macos

  def install
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      To launch the interactive installer run:
        kevdots install

      To backup your current config:
        kevdots backup
    EOS
  end

  def post_install
    (bin/"kevdots").write <<~EOS
      #!/bin/zsh
      DOTS_DIR="#{prefix}"
      case "$1" in
        install) exec zsh "$DOTS_DIR/install.sh" ;;
        backup)  exec zsh "$DOTS_DIR/scripts/backup.sh" ;;
        restore) exec zsh "$DOTS_DIR/scripts/restore.sh" ;;
        *)
          echo "Usage: kevdots [install|backup|restore]"
          exit 1
          ;;
      esac
    EOS
    chmod 0755, bin/"kevdots"
  end

  test do
    assert_predicate prefix/"install.sh", :exist?
  end
end
