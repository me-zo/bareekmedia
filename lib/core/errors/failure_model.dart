enum FailureActions {
  display,
  workAround,
  none,
}

/// Failure Model is used to display errors that come from server,
/// connection issues, databases, or anything that happens outside of the features layer.
class FailureModel {
  final bool hasError;
  final String message;
  final FailureActions failureAction;

  const FailureModel({
    this.message = "",
    this.hasError = true,
    this.failureAction = FailureActions.none,
  });

  FailureModel copyWith({
    bool? hasError,
    String? message,
    FailureActions? failureAction,
  }) =>
      FailureModel(
        hasError: hasError ?? this.hasError,
        message: message ?? this.message,
        failureAction: failureAction ?? this.failureAction,
      );
}
