cask "blackmagic-ai" do
  version "0.5.58"

  on_arm do
    sha256 "a314e45122a6e311d9e7b41d2aadad2004594148f664dc49aa9e9d8eccc8bb2a"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}-arm64.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  on_intel do
    sha256 "411f94f705bc5d250f5d043e62b4206523296486316f8e06ecf17023cb458dd9"
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
