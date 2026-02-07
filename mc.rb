class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-02-07T19-37-38Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "bde4950ffaf8de64962139a199c51da3daec8c8b5983f1699da6ff6d56ccd68a"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "97effe540f778ccbaf966df2466a81dedde9854b542fc15dbd3bbc0294591d50"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "ddb56586d760e74c7886fbbc2c8e075d27fca75fb1149951ec363e15a3d4bf68"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "fc6b6aa2491e5f709c43e452f2ea124e7ff71f7e7e0e2fd0186f06ed5b316f1c"
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
