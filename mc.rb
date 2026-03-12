class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-03-12T04-18-55Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "b83f63bef19fee6680184b14f7355fbcddaa7fc29ed19684ee0f66fd718c8374"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "43b95c1f7f0387fd13ff8dab9e8d4e6e99eb3467bac78f5d54519aaf528a2e1f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "96f3f6a6fbeed9af8078d04ff0944470baffab173d0fc0d33cf29a4783ede919"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "c9500a16f76884f6a1ac60cda91afd7efdf8b5acda43d6ae8b07579ff91500cf"
    end
  end

  conflicts_with "midnight-commander", :because => "Both install `mc`"

  def install
    bin.install Dir.glob("mc.*").first => "mc"
  end

  test do
    system bin/"mc", "mb", testpath/"test"
  end
end
