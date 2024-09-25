import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travoli/feature/dashboard/general/domain/agent_service.dart';

import '../modals/agent.dart';

part 'agent_event.dart';
part 'agent_state.dart';

class AgentBloc extends Bloc<AgentEvent, AgentState> {
  AgentService agentService;
  AgentBloc({required this.agentService}) : super(AgentInitial()) {
    on<GetAgentInfo>(getAgentInfo);
  }

  FutureOr<void> getAgentInfo(GetAgentInfo event, Emitter<AgentState> emit) async {
      emit(AgentLoadingState());
      final  getAgent = await agentService.getAgentInfo(id: event.id);
      getAgent.fold((l){
        print("agent err $l");
        emit(AgentFailureState());
      }, (r){
        print("agent err $r");
        final agent = Agent.fromJson(r["data"]);
         emit(AgentSuccessState(agent: agent));
      });
  }
}
