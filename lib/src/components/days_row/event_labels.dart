import 'package:cell_calendar_plus/src/components/days_row/days_row.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../calendar_event.dart';

/// Numbers to return accurate events in the cell.
const dayLabelContentHeight = 32;
const dayLabelVerticalMargin = 4;
const _dayLabelHeight = dayLabelContentHeight + (dayLabelVerticalMargin * 2);

const _eventLabelContentHeight = 26;
const _eventLabelBottomMargin = 3;
const _eventLabelHeight = _eventLabelContentHeight + _eventLabelBottomMargin;

/// Get events to be shown from [CalendarStateController]
///
/// Shows accurate number of [_EventLabel] by the height of the parent cell
class EventLabels extends HookConsumerWidget {
  EventLabels({
    required this.date,
    required this.events,
  });

  final DateTime date;
  final List<CalendarEvent> events;

  List<CalendarEvent> _eventsOnTheDay(
      DateTime date, List<CalendarEvent> events) {
    final res = events
        .where((event) =>
            event.eventDate.year == date.year &&
            event.eventDate.month == date.month &&
            event.eventDate.day == date.day)
        .toList();
    return res;
  }

  bool _hasEnoughSpace(double cellHeight, int eventsLength) {
    final eventsTotalHeight = _eventLabelHeight * eventsLength;
    final spaceForEvents = cellHeight - _dayLabelHeight;
    return spaceForEvents > eventsTotalHeight;
  }

  int _maxIndex(double cellHeight, int eventsLength) {
    final spaceForEvents = cellHeight - _dayLabelHeight;
    const indexing = 1;
    const indexForPlot = 1;
    return spaceForEvents ~/ _eventLabelHeight - (indexing + indexForPlot);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cellHeight = ref.watch(cellHeightProvider);
    if (cellHeight == null) {
      return const SizedBox.shrink();
    }
    final eventsOnTheDay = _eventsOnTheDay(date, events);
    final hasEnoughSpace = _hasEnoughSpace(cellHeight, eventsOnTheDay.length);
    final maxIndex = _maxIndex(cellHeight, eventsOnTheDay.length);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: eventsOnTheDay.length,
      itemBuilder: (context, index) {
        if (hasEnoughSpace) {
          return _EventLabel(eventsOnTheDay[index]);
        } else if (index < maxIndex) {
          return _EventLabel(eventsOnTheDay[index]);
        } else if (index == maxIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _EventLabel(
                eventsOnTheDay[index],
              ),
              Icon(
                Icons.more_horiz,
                size: 13,
              )
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

/// label to show [CalendarEvent]
class _EventLabel extends StatelessWidget {
  _EventLabel(this.event);

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 7),  // Adicionando padding à esquerda
      height: 21,
      width: double.infinity,
      color: Colors.white,  // Cor de fundo branca
      child: Center(
        child: Text(
          event.eventName,
          style: TextStyle(
            color: Colors.black,  // Texto preto
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(width: 7, color: event.eventBackgroundColor)),  // Borda à esquerda com largura de 7px e cor do evento
      ),
    );
  }
}
