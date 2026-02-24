module.exports = {
  name: 'notification',

  onStreamEnd: async (context) => {
    const { spawn } = require('child_process');
    const os = require('os');

    const platform = os.platform();

    if (platform === 'darwin') {
      // macOS notification
      spawn('osascript', [
        '-e',
        'display notification "Agent response complete" with title "OpenCode"'
      ]);
    } else if (platform === 'linux') {
      // Linux notification (requires notify-send)
      spawn('notify-send', ['OpenCode', 'Agent response complete']);
    }
  }
};
