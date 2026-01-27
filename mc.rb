class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2025-12-19T20-11-44Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "3a0eb0e9c98b559a480e748be56aa910141ae6e28ba81128889b74df5e1d9714"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "71e1a87fc1e8176f2b4d62ae0fbdd5abd906e420696d0f74ec192b47092655d5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "d15e0dedabc5a1c2ddfc59f985332a07a9e72f70947943561eaf5e9a9d6fdb7d"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "83e5a98ddb2d0b91ee2883c2b64f639210873fc06232bbcceafdd80107cbca52"
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
