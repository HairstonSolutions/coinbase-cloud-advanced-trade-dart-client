class PnlConfiguration {
  final TriggerBracketPnl triggerBracketPnl;

  PnlConfiguration({required this.triggerBracketPnl});

  factory PnlConfiguration.fromCBJson(Map<String, dynamic> json) {
    return PnlConfiguration(
      triggerBracketPnl:
          TriggerBracketPnl.fromCBJson(json['trigger_bracket_pnl']),
    );
  }
}

class TriggerBracketPnl {
  final String takeProfitPnl;
  final String stopLossPnl;

  TriggerBracketPnl({required this.takeProfitPnl, required this.stopLossPnl});

  factory TriggerBracketPnl.fromCBJson(Map<String, dynamic> json) {
    return TriggerBracketPnl(
      takeProfitPnl: json['take_profit_pnl'],
      stopLossPnl: json['stop_loss_pnl'],
    );
  }
}
