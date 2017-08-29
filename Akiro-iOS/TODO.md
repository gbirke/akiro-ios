# Next steps for the minimum viable product

## Fast entry 
- Fancy amount input with distinction between income and expense
    - Make nested controllers: ExpenseEntry as the parent controller with an amount label, beneath it a container for amountEntry and expenseDetails. When editing an entry, show expenseDetails, otherwise show amount entry. See https://stackoverflow.com/questions/17499391/ios-nested-view-controllers-view-inside-uiviewcontrollers-view and https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html
    

## Misc
- Convert amount to Decimal instead of Float
- Title for ExpenseEntryView

## Use GPS
- Add GPS entries for each payee
- Pre-populate new entries with nearest payee, if exists
- Show special section "Near you" in payee list

## Add necessary images
- App icon
- Icons for tabs 
    - https://thenounproject.com/search/?q=export&i=976566 for exporting
    - https://thenounproject.com/search/?similar=41949&i=417253 for expenses

# Planned design improvements
- Icon for adding expenses
- Big button at the bottom of the expense list for adding a new expense
- Consistent and prettier color scheme
- Better indicator of which mode (expense/income) is currently active in amount view

# Future developments
- Show date section headers in expense list
- Add accounts - Cash, BTC, etc.
- Add alphabetic section headers in payee selection if no search is done
- Send CSV export via mail
- Put CSV in Dropbox instead of storing it as document
- Delete Payees

## Far future development
- Publish in App Store
- Budgeting
- Encrypted Sync

