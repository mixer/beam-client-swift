//
//  ProgressPacket.swift
//  Pods
//
//  Created by Jack Cook on 3/5/16.
//
//

import SwiftyJSON

/// A packet received when control data has been updated.
public class InteractiveProgressPacket: InteractivePacket {
    
    /// Data on the state of all of the controls in the stream.
    public let controls: [InteractiveProgressPacketControl]
    
    override init?(data: JSON) {
        var controls = [InteractiveProgressPacketControl]()
        
        if let tactiles = data["tactile"].array {
            for tactile in tactiles {
                if let id = tactile["id"].int, let cooldown = tactile["cooldown"].int, let progress = tactile["progress"].int, let disabled = tactile["disabled"].bool {
                    let control = InteractiveProgressPacketTactile(id: id, fired: tactile["fired"].bool ?? false, cooldown: cooldown, progress: progress, disabled: disabled)
                    controls.append(control)
                }
            }
        }
        
        if let joysticks = data["joystick"].array {
            for joystick in joysticks {
                if let id = joystick["id"].int, let angle = joystick["angle"].float, let intensity = joystick["intensity"].float {
                    let control = InteractiveProgressPacketJoystick(id: id, angle: angle, intensity: intensity)
                    controls.append(control)
                }
            }
        }
        
        self.controls = controls
        
        super.init(data: data)
    }
}

/// A representation of a base control's data.
public class InteractiveProgressPacketControl {
    
    /// The id of the control.
    public let id: Int
    
    /**
     Used to initialize a base control's data.
     
     :param: id The id of the control.
     */
    init(id: Int) {
        self.id = id
    }
}

/// A representation of a tactile's control data.
public class InteractiveProgressPacketTactile: InteractiveProgressPacketControl {
    
    /// True if the tactile is currently being pressed.
    public let fired: Bool
    
    /// The remaining seconds of cooldown on the tactile.
    public let cooldown: Int
    
    /// The progress made on pressing this tactile.
    public let progress: Int
    
    /// True if the tactile is disabled.
    public let disabled: Bool
    
    /**
     Used to initialize a tactile's control data.
     
     :param: id The id of the tactile.
     :param: fired True if the tactile is currently being pressed.
     :param: cooldown The remaining seconds of cooldown on the tactile.
     :param: progress The progress made on pressing this tactile.
     :param: disabled True if the tactile is disabled.
     */
    init(id: Int, fired: Bool, cooldown: Int, progress: Int, disabled: Bool) {
        self.fired = fired
        self.cooldown = cooldown
        self.progress = progress
        self.disabled = disabled
        
        super.init(id: id)
    }
}

/// A representation of a joysitck's control data.
public class InteractiveProgressPacketJoystick: InteractiveProgressPacketControl {
    
    /// The angle, in radians, at which the joystick nipple is angled.
    public let angle: Float
    
    /// The distance of the nipple from the center of the joystick, 0.0 < x < 1.0.
    public let intensity: Float
    
    /**
     Used to initialize a joystick's control data.
     
     :param: angle The angle, in radians, at which the joystick nipple is angled.
     :param: intensity The distance of the nipple from the center of the joystick, 0.0 < x < 1.0.
     */
    init(id: Int, angle: Float, intensity: Float) {
        self.angle = angle
        self.intensity = intensity
        
        super.init(id: id)
    }
}
