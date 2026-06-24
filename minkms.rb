class Minkms < Formula
  git_tag = "RELEASE.2026-06-03T18-18-01Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "1e72818bd194382c110aabd49d1af9f457f2c7bf7cf626a54d89b718b00b6981"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "ee6ca3322b8e38c1eecd848a0b9fe4f4d06b7ac5677560142efd717af2f86ff1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "9bcca3e93df074c668f974c454f949e3089dcdab26a6f9dac7e729cf238e3fb8"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "3140a4c84e4d46bfd0de84b45ead782cf28c4a7093c42d3ae3edfafadbc1686a"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
