class Kevdots < Formula
  desc "Personal dotfiles installer — Alacritty + Zellij + LazyVim + Starship + Zsh"
  homepage "https://github.com/KevinDM15/KevDots"
  url "https://github.com/KevinDM15/KevDots/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2221b9259279346813f9718efb254b7ad90f52c6149d3de60fc50bd89076b2b4"
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
