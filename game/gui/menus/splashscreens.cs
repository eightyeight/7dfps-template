new GuiControl(SplashscreenGui) {
   profile = BackgroundProfile;
   horizSizing = "width";
   vertSizing = "height";
   position = "0 0";
   extent = "1024 768";
   minExtent = "8 8";
   wrap = false;

   new GuiTextCtrl() {
      profile = TitleProfile;
      text = "SPLASH SCREENS";
      extent = "250 30";
   };
};

function SplashscreenGui::onWake(%this) {
   InputEvents.subscribe(%this, EvtAdvance);
   %this.endSchedule = %this.schedule(2000, end);
}

function SplashscreenGui::end(%this) {
   GuiEvents.postEvent(EvtSplashscreensDone);
   %this.endSchedule = false;
}

function SplashscreenGui::onSleep(%this) {
   if (%this.endSchedule) {
      cancel(%this.endSchedule);
      %this.endSchedule = "";
   }
   InputEvents.removeAll(%this);
}

function SplashscreenGui::onEvtAdvance(%this) {
   GuiEvents.postEvent(EvtSplashscreensDone);
}
