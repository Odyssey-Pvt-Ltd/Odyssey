package com.Odyssey.Odyssey.dto;

public class DeepSeekResponse {
    private String id;
    private String object;
    private long created;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getObject() {
        return object;
    }

    public void setObject(String object) {
        this.object = object;
    }

    public long getCreated() {
        return created;
    }

    public void setCreated(long created) {
        this.created = created;
    }

    public Choice[] getChoices() {
        return choices;
    }

    public void setChoices(Choice[] choices) {
        this.choices = choices;
    }

    private Choice[] choices;

    public DeepSeekResponse(String id, String object, long created, Choice[] choices) {
        this.id = id;
        this.object = object;
        this.created = created;
        this.choices = choices;
    }



    public static class Choice {
        public int getIndex() {
            return index;
        }

        public void setIndex(int index) {
            this.index = index;
        }

        public Message getMessage() {
            return message;
        }

        public void setMessage(Message message) {
            this.message = message;
        }

        private int index;
        private Message message;



        public static class Message {
            private String role;

            public String getRole() {
                return role;
            }

            public void setRole(String role) {
                this.role = role;
            }

            public String getContent() {
                return content;
            }

            public void setContent(String content) {
                this.content = content;
            }

            private String content;


        }
    }
}