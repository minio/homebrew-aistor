class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-02-19T10-32-25Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "73a175416bb0e91daaf0a2572b11ae61c00cce936b8c0f0d99e6c0ce5c575840"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "3dc293c08cf286d0d8e6e69fd2ffc3557c140234c539e835c44b013a688ee0c5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "8a582cd449fbfe0a695f6dfaf55eb2fb2928a5f2da39993248ee473a1822805c"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "6132ae5f2a49e89d377e656dca6259400155cbe13210f790d1bb6407a5984a9b"
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
