part of 'agent_bloc.dart';

sealed class AgentState extends Equatable {
  const AgentState();
  
  @override
  List<Object> get props => [];
}

final class AgentInitial extends AgentState {
   @override
  List<Object> get props => [];
}

class AgentSuccessState extends AgentState{
  final Agent agent;

  AgentSuccessState({required this.agent});

   @override
  List<Object> get props => [];
}

class AgentLoadingState extends AgentState{
  
   @override
  List<Object> get props => [];
}

class AgentFailureState extends AgentState{
   @override
  List<Object> get props => [];
}
