// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "onBoarding_first_page_subtitle": MessageLookupByLibrary.simpleMessage(
            "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!"),
        "onBoarding_first_page_title":
            MessageLookupByLibrary.simpleMessage("choose your product"),
        "onBoarding_second_page_subtitle": MessageLookupByLibrary.simpleMessage(
            "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!"),
        "onBoarding_second_page_title":
            MessageLookupByLibrary.simpleMessage("Select Payment Method"),
        "onBoarding_third_page_subtitle": MessageLookupByLibrary.simpleMessage(
            "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!"),
        "onBoarding_third_page_title":
            MessageLookupByLibrary.simpleMessage("Deliver at your door step")
      };
}
