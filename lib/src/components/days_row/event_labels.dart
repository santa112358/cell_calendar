import 'package:cell_calendar/src/components/days_row/days_row.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../calendar_event.dart';

/// Numbers to return accurate events in the cell.
const dayLabelContentHeight = 16;
const dayLabelVerticalMargin = 4;
const _dayLabelHeight = dayLabelContentHeight + (dayLabelVerticalMargin * 2);

const _eventLabelContentHeight = 16;
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
    double spaceForEvents = cellHeight - _dayLabelHeight;
    const indexing = 1;
    const indexForPlot = 1;
    // spaceForEvents = spaceForEvents - (_eventLabelHeight + 13);
    return spaceForEvents ~/ _eventLabelHeight - (indexing + indexForPlot);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cellHeight = ref.watch(cellHeightProvider);
    if (cellHeight == null) {
      return const SizedBox.shrink();
    }
    final eventsOnTheDay = _eventsOnTheDay(date, events);
    // final maxIndex = _maxIndex(cellHeight, eventsOnTheDay.length);
    // final hasEnoughSpace = eventsOnTheDay.length >
    //     (maxIndex + 1); //_hasEnoughSpace(cellHeight, eventsOnTheDay.length);

    final maxEventCount = (cellHeight / _eventLabelHeight)
        .toInt(); //_maxIndex(cellHeight, eventsOnTheDay.length);
    final hasEnoughSpace = eventsOnTheDay.length <= maxEventCount;
    final maxIndex = maxEventCount - 1;
    return Container(
      height: cellHeight,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: eventsOnTheDay.length,
        itemBuilder: (context, index) {
          if (hasEnoughSpace) {
            return _EventLabel(
              event: eventsOnTheDay[index],
              bottomSpace: 0.0,
            );
          } else if (index < (maxIndex - 1)) {
            return _EventLabel(event: eventsOnTheDay[index], bottomSpace: 0.0);
          } else if (index == (maxIndex - 1)) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EventLabel(
                    event: eventsOnTheDay[index],
                    bottomSpace: 0,
                  ),
                  Center(
                    child: Text(
                      '${eventsOnTheDay.length - (maxIndex)}+',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

/// label to show [CalendarEvent]
class _EventLabel extends StatelessWidget {
  final double? bottomSpace;
  final CalendarEvent event;

  _EventLabel({required this.event, this.bottomSpace});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: 4,
          bottom: this.bottomSpace ?? _eventLabelBottomMargin.toDouble()),
      height: _eventLabelContentHeight.toDouble(),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: event.eventTypeColor ?? event.eventBackgroundColor,
        border: Border.all(
            color: event.eventTypeBorderColor ?? event.eventBackgroundColor),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Text(
        event.eventName,
        style: event.eventTextStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
