class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-09-06T02-44-40Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "24400a435a2c168f754d89c18fe63282855deccf300da3c89dae2f4e0e23a11f"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "be170be82ea275515546f653a2f03bf93149dd2cba9802cb651a09fd3311ae7b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "3283b779571988a31f747f3c4f8414fa1fa20eff263ec12fd5d47278ad5e5d7b"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "5a07c01f2e90ea3f2995d69bd69ea1a77af1d431a376e509eaa800074f789a37"
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
