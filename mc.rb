class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2025-08-29T21-30-41Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "886fb0d8455b27b96e6cd96dc1c4f51b96cfc8a45bf1b9bb90cdb95f034bf5d5"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "08c5c071996f434c43440685a8e7a08ed8eaf28167f2e784855b4bded34a178c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "3146c3abcc60f51ebab8e64b643a9ba12e68a9b165f724e4674e1bebff5e0623"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "8be9c3ac8fda92ce39efafc2e5b7250bf0295408c481c2c03c5a10b5ff78f40c"
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
