class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2025-08-21T03-14-05Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "c9978aa36454714ecc3521ec55ee34b04c6f6090e341665ded7fcde0b763b9b9"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "2878055932ae06c909d0aa6c51cf0fca5a86f7ce894c1d79dbcd49a05105cf1e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "9f2e2a81f50bbfc55c46baee97b00111a45a69b50f2f6a37094934e461305011"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "a326e1249b718d581215dd379a35fdc4086a93a7d27bfe25cf71698096685949"
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
