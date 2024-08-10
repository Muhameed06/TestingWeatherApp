String getFormattedDateTime() {
  final now = DateTime.now();
  final isDaytime = now.hour >= 6 && now.hour < 18;
  
  final daysOfWeek = [
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
  ];
  
  final dayOfWeek = daysOfWeek[now.weekday - 1];
  final dayOfMonth = now.day.toString().padLeft(2, '0');  
  final minute = now.minute.toString().padLeft(2, '0');
  
  if (isDaytime) {
    final hour12 = now.hour % 12;
    final formattedHour12 = hour12 == 0 ? 12 : hour12.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    
    return '$dayOfWeek $dayOfMonth - $formattedHour12:$minute $period';
  } else {
    final hour24 = now.hour.toString().padLeft(2, '0');
    
    return '$dayOfWeek $dayOfMonth - $hour24:$minute';
  }
}