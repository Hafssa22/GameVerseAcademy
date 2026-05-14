package ma.ac.esi.gameverseacademy.model;

import java.sql.Timestamp;

public class Profile {

    private int       id;
    private String    userEmail;
    private String    username;
    private String    bio;
    private String    avatarUrl;
    private String    location;
    private String    website;
    private Timestamp createdAt;

    public Profile() {}

    public Profile(int id, String userEmail, String username, String bio,
                   String avatarUrl, String location, String website, Timestamp createdAt) {
        this.id        = id;
        this.userEmail = userEmail;
        this.username  = username;
        this.bio       = bio;
        this.avatarUrl = avatarUrl;
        this.location  = location;
        this.website   = website;
        this.createdAt = createdAt;
    }

    // Getters
    public int       getId()        { return id;        }
    public String    getUserEmail() { return userEmail; }
    public String    getUsername()  { return username;  }
    public String    getBio()       { return bio;       }
    public String    getAvatarUrl() { return avatarUrl; }
    public String    getLocation()  { return location;  }
    public String    getWebsite()   { return website;   }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters
    public void setId(int id)               { this.id        = id;        }
    public void setUserEmail(String email)  { this.userEmail = email;     }
    public void setUsername(String username){ this.username  = username;  }
    public void setBio(String bio)          { this.bio       = bio;       }
    public void setAvatarUrl(String url)    { this.avatarUrl = url;       }
    public void setLocation(String loc)     { this.location  = loc;       }
    public void setWebsite(String web)      { this.website   = web;       }
    public void setCreatedAt(Timestamp t)   { this.createdAt = t;         }
}