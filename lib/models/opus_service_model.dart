

class OpusServiceResponse {
  final bool isValid;
  final bool hasError;
  final String? errorMessage;
  final bool isRecording;
  final bool isRecordingPaused;
  final bool isRecordingStopped;
  final String? recordDuration;
  final bool isPlaying;
  final bool isPlayingPaused;
  final bool isPlayingStopped;
  final int playDuration;
  final int playDurationTotal;

  OpusServiceResponse({
    this.isValid = false,
    this.hasError = false,
    this.errorMessage,
    this.isRecording = false,
    this.isRecordingPaused = false,
    this.isRecordingStopped = false,
    this.recordDuration,
    this.isPlaying = false,
this.isPlayingPaused = false,
this.isPlayingStopped = false,
this.playDuration = 0,
this.playDurationTotal = 0,
  });

  factory OpusServiceResponse.fromJson(Map<String, dynamic> map) {
    return OpusServiceResponse(
      isValid: map['isValid'] ?? false,
      hasError: map['hasError'] ?? false,
      errorMessage: map['errorMessage'],
      isRecording: map['isRecording'] ?? false,
      isRecordingPaused: map['isRecordingPaused'] ?? false,
      isRecordingStopped: map['isRecordingStopped'] ?? false,
      recordDuration: map['recordDuration'],
      isPlaying: map['isPlaying'] ?? false,
      isPlayingPaused: map['isPlayingPaused'] ?? false,
      isPlayingStopped: map['isPlayingStopped'] ?? false,
      playDuration: map['playDuration'] ?? false,
      playDurationTotal: map['playDurationTotal'] ?? false,
    );
  }

  @override
  String toString() {
    return 'OpusServiceResponse(\nisValid: $isValid,\n hasError: $hasError,\n errorMessage: $errorMessage,\n isRecording: $isRecording,\n isRecordingPaused: $isRecordingPaused,\n isRecordingStopped: $isRecordingStopped,\n recordDuration: $recordDuration,\n isPlaying: $isPlaying,\n isPlayingPaused: $isPlayingPaused,\n isPlayingStopped: $isPlayingStopped,\n playDuration: $playDuration,\n playDurationTotal: $playDurationTotal\n)';
  }
}
