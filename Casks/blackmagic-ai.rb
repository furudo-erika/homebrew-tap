cask "blackmagic-ai" do
  version "0.4.30"

  on_arm do
    sha256 "829d6d02325c4a5293452622fadbdddf2f40d18daa678c3d0bed93cb51204922"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}-arm64.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  on_intel do
    sha256 "6bf7d0c28b60598ab9c5a14aeba61dee1d5268ee9e8f21aa2c77a100a6bf55af"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  name "BlackMagic AI"
  desc "Agent-first AI desktop app"
  homepage "https://github.com/furudo-erika/blackmagic-desktop"

  app "BlackMagic AI.app"

  # Belt-and-suspenders: strip quarantine + any lingering xattrs on the
  # installed app. Our build re-signs ad-hoc in afterPack, which resolves
  # the "app is damaged" Gatekeeper error caused by Electron's default
  # linker-signed stub having a mismatched identifier.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/BlackMagic AI.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/BlackMagic AI",
    "~/Library/Logs/BlackMagic AI",
    "~/Library/Preferences/run.blackmagic.desktop.plist",
    "~/Library/Saved Application State/run.blackmagic.desktop.savedState",
  ]
end
