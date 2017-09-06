/**
 * Created by Patrick O'Connor on 8/30/17.
 */

package com.robertsheao.RNZenDeskSupport;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.zendesk.sdk.feedback.ui.ContactZendeskActivity;
import com.zendesk.sdk.requests.RequestActivity;
import com.zendesk.sdk.support.SupportActivity;
import com.zendesk.sdk.support.ContactUsButtonVisibility;
import com.zendesk.sdk.model.access.AnonymousIdentity;
import com.zendesk.sdk.model.access.Identity;
import com.zendesk.sdk.model.request.CustomField;
import com.zendesk.sdk.network.impl.ZendeskConfig;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class RNZenDeskSupportModule extends ReactContextBaseJavaModule {
  public RNZenDeskSupportModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  public String getName() {
    return "RNZenDeskSupport";
  }

  @ReactMethod
  public void callSupport(ReadableMap identity, ReadableMap customFields) {

    Identity zdIdentity = new AnonymousIdentity.Builder()
      .withEmailIdentifier(identity.getString("customerEmail"))
      .withNameIdentifier(identity.getString("customerName"))
      .build();

    ZendeskConfig.INSTANCE.setIdentity(zdIdentity);

    List<CustomField> fields = new ArrayList<>();

    for (Map.Entry<String, Object> next : customFields.toHashMap().entrySet())
      fields.add(new CustomField(Long.parseLong(next.getKey()), (String) next.getValue()));

    ZendeskConfig.INSTANCE.setCustomFields(fields);

    ContactZendeskActivity.startActivity(getReactApplicationContext(), null);
  }

  @ReactMethod
  public void supportHistory(ReadableMap identity) {
    Identity zdIdentity = new AnonymousIdentity.Builder()
          .withEmailIdentifier(identity.getString("customerEmail"))
          .withNameIdentifier(identity.getString("customerName"))
          .build();
    RequestActivity.startActivity(getReactApplicationContext(), null);
  }

}
