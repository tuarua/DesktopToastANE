#include "stdafx.h"
#include "ToastEventHandler.h"
#include <iostream>
#include "FlashRuntimeExtensions.h"
using namespace ABI::Windows::UI::Notifications;

ToastEventHandler::ToastEventHandler(_In_ HWND hToActivate, _In_ HWND hEdit, _In_ FREContext dllContext) : _ref(1), _hToActivate(hToActivate), _hEdit(hEdit), _dllContext(dllContext) {

}

ToastEventHandler::~ToastEventHandler()
{
    
}

// DesktopToastActivatedEventHandler
IFACEMETHODIMP ToastEventHandler::Invoke(_In_ IToastNotification* /* sender */, _In_ IInspectable* /* args */)
{
    BOOL succeeded = SetForegroundWindow(_hToActivate);
    if (succeeded)
    {
		std::string msg = "";
		std::string evnt = "Toast.Clicked";
		FREDispatchStatusEventAsync(_dllContext, (uint8_t*)msg.c_str(), (const uint8_t*)evnt.c_str());

        //LRESULT result = SendMessage(_hEdit, WM_SETTEXT, reinterpret_cast<WPARAM>(nullptr), reinterpret_cast<LPARAM>(L"The user clicked on the toast."));
        //succeeded = result ? TRUE : FALSE;
    }
    return succeeded ? S_OK : E_FAIL;
}

std::string wcharToString(const wchar_t* arg) {
	using namespace std;
	std::wstring ws(arg);
	std::string str(ws.begin(), ws.end());
	return str;
}

// DesktopToastDismissedEventHandler
IFACEMETHODIMP ToastEventHandler::Invoke(_In_ IToastNotification* /* sender */, _In_ IToastDismissedEventArgs* e) {
    ToastDismissalReason tdr;
    HRESULT hr = e->get_Reason(&tdr);

    if (SUCCEEDED(hr)) {
        //wchar_t *outputText;
		std::string evnt;
		std::string msg = "";
        switch (tdr) {
        case ToastDismissalReason_ApplicationHidden:
			evnt = "Toast.Hidden";
           // outputText = L"The application hid the toast using ToastNotifier.hide()";
            break;
        case ToastDismissalReason_UserCanceled:
			evnt = "Toast.Dismissed";
           // outputText = L"The user dismissed this toast";
            break;
        case ToastDismissalReason_TimedOut:
			evnt = "Toast.TimedOut";
           // outputText = L"The toast has timed out";
            break;
        default:
			evnt = "Toast.NotActivated";
           // outputText = L"Toast not activated";
            break;
        }

		//std::wcout << outputText;
		//std::string msg = wcharToString(outputText);
		FREDispatchStatusEventAsync(_dllContext, (uint8_t*)msg.c_str(), (const uint8_t*)evnt.c_str());

       // LRESULT succeeded = SendMessage(_hEdit, WM_SETTEXT, reinterpret_cast<WPARAM>(nullptr), reinterpret_cast<LPARAM>(outputText));
       // hr = succeeded ? S_OK : E_FAIL;
    }
    return hr;
}

// DesktopToastFailedEventHandler
IFACEMETHODIMP ToastEventHandler::Invoke(_In_ IToastNotification* /* sender */, _In_ IToastFailedEventArgs* /* e */) {
	std::string msg = "";
	std::string evnt = "Toast.Error";
	FREDispatchStatusEventAsync(_dllContext, (uint8_t*)msg.c_str(), (const uint8_t*)evnt.c_str());
   // LRESULT succeeded = SendMessage(_hEdit, WM_SETTEXT, reinterpret_cast<WPARAM>(nullptr), reinterpret_cast<LPARAM>(L"The toast encountered an error."));
    
	return S_OK;
}
