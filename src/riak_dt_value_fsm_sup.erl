%%%-------------------------------------------------------------------
%%% @author Russell Brown <russelldb@basho.com>
%%% @copyright (C) 2011, Russell Brown
%%% @doc
%%% kicks off riak_dt_value_fsms on a 141 basis
%%% @end
%%% Created : 22 Nov 2011 by Russell Brown <russelldb@basho.com>
%%%-------------------------------------------------------------------
-module(riak_dt_value_fsm_sup).
-behaviour(supervisor).

-export([start_value_fsm/2]).
-export([start_link/0]).
-export([init/1]).

start_value_fsm(Node, Args) ->
    supervisor:start_child({?MODULE, Node}, Args).

%% @spec start_link() -> ServerRet
%% @doc API for starting the supervisor.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% @spec init([]) -> SupervisorTree
%% @doc supervisor callback.
init([]) ->
    ValueFsmSpec = {undefined,
               {riak_dt_value_fsm, start_link, []},
               temporary, 5000, worker, [riak_dt_value_fsm]},

    {ok, {{simple_one_for_one, 10, 10}, [ValueFsmSpec]}}.