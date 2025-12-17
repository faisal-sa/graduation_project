/*
 ============================================================================
.                              APP VALIDATORS
 ============================================================================
 This file is the single source of truth for all input validation in the app.

 It contains ONLY the following validators:
 - validateName
- validateRole
- validateEmail
- validatePassword
- validateConfirmPassword
- validateOTP

  !! it can be scaled up to more validators as needed !!

RULES & GUIDELINES:

1. Do NOT create validators outside this file.



2. All validators must be pure functions:
   - No side effects
   - No async work
   - No dependency on UI, context, or state.



3. Each validator has a single responsibility (SRP):
   - Validate one thing, and one thing only.



4. Validators must return `String?`:
   - `null`   → valid input
   - `String` → validation error message.



5. Validation is UI-agnostic:
   - AppTextField (already implemented) is responsible for calling validators.
   - Validators never interact with widgets or form logic.



6. Keep validation rules centralized and consistent:
   - Any change to validation behavior must be done here.
   - This guarantees predictable behavior across the entire app.



============================================================================
NOTE:
- Follow OOP and SOLID principles at all times.
- This file exists to prevent validation duplication and logic drift.
- If you think you need a new validator, you probably need to reuse or
  extend an existing one in this file instead.
============================================================================ 
 
 
*/

class Validators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  static String? validateRole(String? role) {
    if (role == null || role.isEmpty) {
      return 'Please select your role';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? confirm, String? password) {
    if (confirm == null || confirm.isEmpty) {
      return 'Please confirm your password';
    }
    if (confirm != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter OTP code';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }
}
