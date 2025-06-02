class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2025-05-28T03-50-32Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "73f068dc80b364697c54fa21bdbdc5e5a2b730900f9a01ead0efa4f531a21fed"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "181d6da3453e2110c07a49983a327ec2a4e55603adcd54c7efdc69241c3d38df"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "6e5f8efda4c3adaaab1a170d58cdc42d348abcfe485798d3b8b9d911ed611783"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "fbccfe5e2cbe4d6cb1d1d70df927a6e370a9ceb9fd7340b64787cc5b84b757d1"
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
