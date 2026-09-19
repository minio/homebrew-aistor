class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-09-19T15-24-59Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "153b59c059621afdc9d3a0756bcba12bd24d815be7d4b48fb8cc3cdfaa71c269"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "26cdd6d51913ddc597704796c80d1607b930cccbdd27624abe9f605a8429fb03"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "20f9efeb4fe16bfef022d640a393f77c85b957c08b4c5987ecc42f9f2b98e82b"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "83938eded435e7c28c397ece1dc590b2a79626dd9354aae2107060fec559ae2b"
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
