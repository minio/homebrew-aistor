class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-04-11T06-53-06Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "339078e93329e29ef179c50f72c945a3d450bb2d49a7436190d5d74caa26c64a"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "3fba5d7cb238a3fe9e79a53612107857444a21e870442bd6de4eb68a23cf6b37"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "9c79e18d74e51ca55107ab77eaf3c122d24aa8475402b7c505914efd272dfa34"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "eb01cb7d985b0dc124bcfa3b7476a06487167d4127affe972a8b3b2d2f489a56"
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
