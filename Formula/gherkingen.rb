# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Gherkingen < Formula
  desc "BDD tests boilerplate generator for Golang"
  homepage "https://github.com/hedhyw/gherkingen"
  version "0.0.1-rc.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/hedhyw/gherkingen/releases/download/v0.0.1-rc.0/gherkingen_darwin_amd64.tar.gz"
      sha256 "3103869f27d229816c71148fb3c18e02d12c946f4ac9e25a2cc321b625eab6cf"

      def install
        bin.install "gherkingen"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/hedhyw/gherkingen/releases/download/v0.0.1-rc.0/gherkingen_darwin_arm64.tar.gz"
      sha256 "5b5acd122c790086d420e8bebf4e9dd8eec95e67f05d07227ac0f6afd2a36c65"

      def install
        bin.install "gherkingen"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/hedhyw/gherkingen/releases/download/v0.0.1-rc.0/gherkingen_linux_arm.tar.gz"
      sha256 "9f67e25122cc5642d9d0e809bf19898cae1b3cb4d184891c5b586bce46ef4631"

      def install
        bin.install "gherkingen"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/hedhyw/gherkingen/releases/download/v0.0.1-rc.0/gherkingen_linux_arm64.tar.gz"
      sha256 "a5e56293b10f854305f255b7c84b45c759993c491ed16648c6374c0ef2b79aef"

      def install
        bin.install "gherkingen"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedhyw/gherkingen/releases/download/v0.0.1-rc.0/gherkingen_linux_amd64.tar.gz"
      sha256 "2291a7fc25ee7f7f561161a94e04cbba1d0bb9a80a65b26612fe484b9f3eac7d"

      def install
        bin.install "gherkingen"
      end
    end
  end

  test do
    system "#{bin}/gherkingen", "-help"
  end
end
