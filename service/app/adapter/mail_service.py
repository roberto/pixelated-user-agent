import traceback
import sys
import os
from app.bitmask_libraries.config import LeapConfig
from app.bitmask_libraries.provider import LeapProvider
from app.bitmask_libraries.session import LeapSessionFactory
from app.bitmask_libraries.auth import LeapCredentials


class MailService:
    def __init__(self):
        try:
            self.username = 'test_user'
            self.password = 'testpassword'
            self.server_name = 'example.wazokazi.is'
            self.mailbox_name = 'inbox'
            self.leapdir = os.path.join(os.path.abspath("."), "leap")

            self._open_leap_session()
        except:
            traceback.print_exc(file=sys.stdout)
            raise

    def _open_leap_session(self):
        self.leap_config = LeapConfig(leap_home=self.leapdir)
        self.provider = LeapProvider(self.server_name, self.leap_config)
        self.leap_session = LeapSessionFactory(self.provider).create(LeapCredentials(self.username, self.password))
        self.mail_box = self.leap_session.account.getMailbox(self.mailbox_name)

    def mails(self, query):
        return self.mail_box.messages


    def drafts(self):
        return []

    def mail(self, mail_id):
        raise NotImplementedError()

    def thread(self, thread_id):
        raise NotImplementedError()

    def mark_as_read(self, mail_id):
        raise NotImplementedError()

    def tags_for_thread(self, thread):
        raise NotImplementedError()

    def add_tag_to_thread(self, thread_id, tag):
        raise NotImplementedError()

    def remove_tag_from_thread(self, thread_id, tag):
        raise NotImplementedError()

    def delete_mail(self, mail_id):
        raise NotImplementedError()

    def save_draft(self, draft):
        raise NotImplementedError()

    def send_draft(self, draft):
        raise NotImplementedError()

    def draft_reply_for(self, mail_id):
        raise NotImplementedError()

    def all_tags(self):
        raise NotImplementedError()

    def all_contacts(self, query):
        raise NotImplementedError()

if __name__ == '__main__':
    print('Running Standalone')
    client = Client()