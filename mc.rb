class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-02-03T00-12-26Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "bb5172788ea26c008a52b2eec07c723d313662bc22bec91633df4abacad601ee"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "8564ae5387b6e0eb86f92253f7d101155a15dbd40297c471cff599baf9643200"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "cfaf35088cde4b71dd130e5484d9008aaef1829bda4221c9be9b3719ad24de24"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "e0d34371ad42e7cf4a691a11b76198a3508cf30feb3a962617471beaaf7e43da"
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
