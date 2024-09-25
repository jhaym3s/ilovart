part of 'agent_bloc.dart';

sealed class AgentEvent extends Equatable {
  const AgentEvent();

  
}

class GetAgentInfo extends AgentEvent{
final String id;

GetAgentInfo({required this.id});
  @override
  List<Object> get props => [];
}
