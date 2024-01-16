  // convert DateTime into a String yyyymmdd
  String convertDateTimeToString(DateTime dateTime){
   //year in the forma ->yyyy
   String year = dateTime.year.toString();
   String month = dateTime.month.toString();
   if(month.length == 1){
     month = '0$month';
   }
   String day = dateTime.day.toString();
   if(day.length == 1){
     day = '0$day';
   }

   String yyyymmdd = year + month + day;

   return yyyymmdd;

  }
